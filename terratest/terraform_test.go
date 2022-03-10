package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/complete using Terratest.
// Make sure you have the dep binary, https://github.com/golang/dep
// Run 'dep ensure' before run test cases.

func TestTerraformBasicExampleNew(t *testing.T) {
	t.Parallel()
	uniqueId := random.Random(100, 1000)
	uniqueName := fmt.Sprintf("tf-testacc%d.xiaozhu.com", uniqueId)
	domainName := uniqueName
	// Currently, there is an bug if setting checkurl and biz_name
	// check_url := "www.aliyun.com"
	//biz_name := "scdn"
	sources := map[string]string{
		"content":  "1.1.1.1",
		"port":     "80",
		"priority": "20",
		"type":     "ipaddr",
	}
	status := "online"
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./basic/",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"domain_name": domainName,
			//"check_url":      check_url,
			//biz_name:  biz_name,
			"sources": sources,
			"status":  status,
			// We also can see how lists and maps translate between terratest and terraform.
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: false,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualDomain := trimMarks(terraform.Output(t, terraformOptions, "this_domain_name"), `"`)
	actualStatus := trimMarks(terraform.Output(t, terraformOptions, "this_domain_status"), `"`)
	actualDomainConfigIds := terraform.OutputList(t, terraformOptions, "this_domain_config_ids")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, domainName, actualDomain)
	assert.Equal(t, status, actualStatus)
	assert.Equal(t, 2, len(actualDomainConfigIds))
}

func trimMarks(str string, mark string) string {
	return strings.TrimPrefix(strings.TrimSuffix(str, mark), mark)
}
