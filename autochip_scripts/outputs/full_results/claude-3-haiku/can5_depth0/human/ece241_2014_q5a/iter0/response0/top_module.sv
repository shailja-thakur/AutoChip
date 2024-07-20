module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 1'b0;
parameter COMPUTE = 1'b1;

reg state;
reg [7:0] sum;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        sum <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x) begin
                    state <= COMPUTE;
                    sum <= 8'b11111111; // initialize 2's complement
                end
            end
            COMPUTE: begin
                sum <= {sum[6:0], ~x}; // shift in the complement of the input bit
                z <= sum[7]; // output the MSB of the 2's complement
                if (x) begin
                    // continue computing 2's complement
                end
                else begin
                    state <= IDLE; // stop when input is 0
                end
            end
        endcase
    end
end

endmodule
