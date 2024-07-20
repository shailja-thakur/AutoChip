module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    // States
    parameter B = 2'b00;
    parameter A = 2'b01;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B; // Reset to state B
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
                default: state <= B;
            endcase
        end
    end

    always @(state) begin
        case (state)
            B: begin
                out_reg <= 1'b1;
            end
            A: begin
                out_reg <= 1'b0;
            end
            default: out_reg <= 1'b1;
        endcase
    end

    assign out = out_reg;

endmodule
