module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State definitions
    parameter A = 3'b00;
    parameter B = 3'b01;
    parameter C = 3'b10;
    parameter D = 3'b11;

    // State variable
    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            case(state)
                A: begin
                    if (w) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= C;
                    end
                end
                C: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= D;
                    end
                end
                D: begin
                    if (w) begin
                        state <= C;
                    end else begin
                        state <= A;
                    end
                end
            endcase
        end
    end

    assign z = (state == D);

endmodule
