module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State parameter definitions
localparam STATE_RESET = 2'b00;
localparam STATE_COMPUTE = 2'b01;
localparam STATE_DONE = 2'b11;

// Register to hold the current state
reg [1:0] state;

// Register to hold the intermediate result
reg [7:0] result;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        result <= 8'b0;
        z <= 1'b0;
    end else begin
        case (state)
            STATE_RESET: begin
                state <= STATE_COMPUTE;
            end
            STATE_COMPUTE: begin
                result <= {result[6:0], x};
                if (result[7]) begin
                    z <= ~result[7:0] + 1'b1;
                    state <= STATE_DONE;
                end
            end
            STATE_DONE: begin
                if (areset) begin
                    state <= STATE_RESET;
                    result <= 8'b0;
                    z <= 1'b0;
                end
            end
            default: begin
                state <= STATE_RESET;
            end
        endcase
    end
end

endmodule
