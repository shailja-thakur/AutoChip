module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg out;
reg [1:0] state;
reg prev_in;
parameter B = 2'b0;
parameter A = 2'b1;

always @(posedge clk) begin
    if (reset == 1'b1) begin
        state <= B;
    end else begin
        case (state)
            B: begin
                if (in == 1'b0) begin
                    state <= A;
                end else begin
                    state <= B;
                end
            end
            A: begin
                if (in == 1'b0) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            default: begin
                state <= B;
            end
        endcase
    end
end

always @(state) begin
    case (state)
        B: begin
            out <= 1'b1;
        end
        A: begin
            out <= 1'b0;
        end
        default: begin
            out <= 1'b1;
        end
    endcase
end

endmodule
