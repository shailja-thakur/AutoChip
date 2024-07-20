module top_module (
    input [7:0] in,
    output [31:0] out
);

assign out = {in, {24{in}}};

endmodule
module top_module (` - This declares the module named `top_module`.
2. `    input [7:0] in,` - This declares an 8-bit input port named `in`.
3. `    output [31:0] out` - This declares a 32-bit output port named `out`.
4. `);` - This closes the module declaration.
5. `assign out = {in, {24{in}}};` - This is the combinational logic that assigns the output. It concatenates the original 8-bit input `in` with 24 copies of the same input, creating the 32-bit output.
6. `endmodule
