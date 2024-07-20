module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
localparam [1:0] IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b11;

// Declare internal registers
reg [7:0] num;
reg [1:0] state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        z <= 1'b0;
        num <= 8'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!x) begin
                    state <= COMPUTE;
                    num <= 8'b0;
                end
            end
            COMPUTE: begin
                num <= {num[6:0], x};
                if (x) begin
                    z <= ~num[7:0] + 1'b1;
                end
                else begin
                    z <= num[7:0];
                end
                if (areset) begin
                    state <= IDLE;
                end
            end
            DONE: begin
                // No operation
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
