module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define states for the state machine
localparam S_INIT = 0, S_CONVERT = 1;
reg state, next_state;

// Register to hold the intermediate result
reg [7:0] result;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S_INIT;
        result <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            S_INIT: begin
                result <= 0;
                z <= 0;
            end
            S_CONVERT: begin
                result <= {result[6:0], x};
                z <= ~result[7] & (|result[7:0]);
            end
        endcase
    end
end

always @(*) begin
    case (state)
        S_INIT: next_state = (areset) ? S_INIT : S_CONVERT;
        S_CONVERT: next_state = (areset) ? S_INIT : S_CONVERT;
        default: next_state = S_INIT;
    endcase
end

endmodule
