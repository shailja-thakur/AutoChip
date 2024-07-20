module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg current_state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A;
    end
    else begin
        case (current_state)
            A: begin
                if (j) begin
                    current_state <= B;
                end
                else begin
                    current_state <= A;
                end
            end
            B: begin
                if (k) begin
                    current_state <= A;
                end
                else begin
                    current_state <= B;
                end
            end
            default: begin
                current_state <= A;
            end
        endcase
    end
end

always @(*) begin
    case (current_state)
        A: begin
            out <= 1'b0;
        end
        B: begin
            out <= 1'b1;
        end
        default: begin
            out <= 1'b0;
        end
    endcase
end

endmodule
