// 
The top module has the following inputs and outputs
Inputs: clk and x
Outputs: z

The following registers are defined
Register s is 3 bits and its inital value is 0

The following operations are performed
Always block
	Cascade notation is used to represent the state of s
	The first element is the MSB of s 
	The second element is the middle bit of s 
	The third element is the LSB of s 
	The following statements are implemented in the always block
		Statement 1:
			The MSB of s is s[2]
			The value of x is exlusive ORed with the MSB of s
			The value of x is also assigned to the LSB of s
		Statement 2:
			The middle bit of s is s[1]
			The NOT operator is applied to the middle bit of s
			The value of x is ANDed with the output of the NOT operator
			The output of the AND operation is assigned to the middle bit of s
		Statement 3:
			The LSB of s is s[0]
			The NOT operator is applied to the LSB of s
			The value of x is ORed with the output of the NOT operator
			The output of the OR operation is assigned to the LSB of s
	
Assign output z
	The OR operator is applied to all bits of s
	The NOT operator is applied to the output of the OR operator
	The output of the NOT operator is assigned to output z





module top_module (
	input clk,
	input x,
	output z
);
