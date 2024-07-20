module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

// Define internal signals
reg [31:0] register;
wire feedback;

// Assign feedback signal
assign feedback = register[31] ^ register[21] ^ register[1] ^ register[0];

// Synchronous reset
always @(posedge clk) begin
    if (reset) begin
        register <= 32'h1;
    end else begin
        register <= {register[30:0], feedback};
    end
end

// Output assignment
always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end else begin
        q <= register;
    end
end

endmodule
