module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [31:0] count; // Counter to keep track of the number of input bits
reg [31:0] sum; // State variable to keep track of the accumulated sum
reg [31:0] x_complement; // Complement of the input x
reg output_valid; // Output valid signal
reg output_enable; // Output enable signal

// Positive edge triggered asynchronous reset
always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 0;
        sum <= 0;
        x_complement <= 0;
        output_valid <= 0;
        output_enable <= 0;
    end else begin
        count <= count + 1;
        if (count < 32) begin
            sum <= sum + x;
            x_complement <= x_complement + ~x + 1;
        end
        if (count == 31) begin
            output_valid <= 1;
        end else if (output_valid && !areset) begin
            output_enable <= 1;
        end else begin
            output_enable <= 0;
        end
    end
end

// Assign the output signal z based on the current state
assign z = output_enable ? x_complement : 0;

endmodule
