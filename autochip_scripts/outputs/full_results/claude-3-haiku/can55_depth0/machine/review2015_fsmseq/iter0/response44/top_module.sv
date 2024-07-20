module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [2:0] state;
parameter S = 3'b000, S1 = 3'b001, S11 = 3'b011, S110 = 3'b110, DONE = 3'b111;

always @(posedge clk) begin
    if (reset)
        state <= S;
    else begin
        case (state)
            S: begin
                if (data)
                    state <= S1;
                else
                    state <= S;
            end
            S1: begin
                if (data)
                    state <= S11;
                else
                    state <= S;
            end
            S11: begin
                if (data)
                    state <= S11;
                else
                    state <= S110;
            end
            S110: begin
                if (data)
                    state <= DONE;
                else
                    state <= S;
            end
            DONE: begin
                state <= DONE;
            end
            default:
                state <= S;
        endcase
    end
end

always @(*) begin
    case (state)
        DONE: start_shifting = 1'b1;
        default: start_shifting = 1'b0;
    endcase
end

endmodule
