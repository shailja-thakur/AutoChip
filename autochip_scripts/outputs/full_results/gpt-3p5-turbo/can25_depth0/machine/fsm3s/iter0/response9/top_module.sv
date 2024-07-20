module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Declare the states as parameters
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            case(state)
                A: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= C;
                    end
                end
                C: begin
                    if (in) begin
                        state <= D;
                    end else begin
                        state <= A;
                    end
                end
                D: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= C;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == D) begin
            out_reg <= 1;
        end else begin
            out_reg <= 0;
        end
    end

    assign out = out_reg;

endmodule
