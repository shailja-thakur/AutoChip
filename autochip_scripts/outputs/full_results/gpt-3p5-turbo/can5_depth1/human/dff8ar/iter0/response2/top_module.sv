module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q );

    reg [7:0] q_temp; // temporary register for storing intermediate values

    always @(posedge clk or areset) begin
        if (areset) begin
            q_temp <= 8'b00000000; // reset the temporary register to 0
        end else begin
            q_temp <= d; // store the input data
        end
    end
    
    always @(posedge clk) begin
        q <= q_temp; // assign the temporary register value to the output
    end

endmodule
