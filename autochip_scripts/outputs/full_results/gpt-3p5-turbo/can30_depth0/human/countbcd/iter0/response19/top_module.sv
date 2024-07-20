module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [3:0] q0, q1, q2, q3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q0 <= 4'b0000;
            q1 <= 4'b0000;
            q2 <= 4'b0000;
            q3 <= 4'b0000;
        end else begin
            if (ena[3]) begin
                if (q0 == 9) begin
                    q0 <= 4'b0000;
                    if (q1 == 9) begin
                        q1 <= 4'b0000;
                        if (q2 == 9) begin
                            q2 <= 4'b0000;
                            if (q3 == 9) begin
                                q3 <= 4'b0000;
                            end else begin
                                q3 <= q3 + 1;
                            end
                        end else begin
                            q2 <= q2 + 1;
                        end
                    end else begin 
                        q1 <= q1 + 1;
                    end 
                end else begin
                    q0 <= q0 + 1;
                end
            end
        end
    end

    assign q = {q3, q2, q1, q0};

endmodule
