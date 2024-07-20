module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [2:0] state;
parameter S = 3'b000, S1 = 3'b001, S11 = 3'b011, S110 = 3'b110, Done = 3'b111;

always @(posedge clk) begin
    if (reset) begin
        state <= S;
    end else begin
        case (state)
            S: begin
                if (data) begin
                    state <= S1;
                end else begin
                    state <= S;
                end
            end
            S1: begin
                if (data) begin
                    state <= S11;
                end else begin
                    state <= S;
                end
            end
            S11: begin
                if (data) begin
                    state <= S11;
                end else begin
                    state <= S110;
                end
            end
            S110: begin
                if (data) begin
                    state <= Done;
                end else begin
                    state <= S;
                end
            end
            Done: begin
                state <= Done;
            end
            default: begin
                state <= S;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        Done: begin
            start_shifting = 1'b1;
        end
        default: begin
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
