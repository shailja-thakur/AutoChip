module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    // State codes
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;

    // State register
    reg [2:0] state;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (r[1] || r[2] || r[3]) begin
                        if (r[1]) begin
                            state <= B;
                        end else if (r[2]) begin
                            state <= C;
                        end else if (r[3]) begin
                            state <= D;
                        end
                    end
                end
                B: begin
                    if (r[1]) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                C: begin
                    if (r[2]) begin
                        state <= C;
                    end else begin
                        state <= A;
                    end
                end
                D: begin
                    if (r[1] || r[2] || r[3]) begin
                        state <= D;
                    end else begin
                        state <= A;
                    end
                end
            endcase
        end
    end

    // Output assignments
    assign g[1] = (state == B || state == D) ? 1 : 0;
    assign g[2] = (state == C) ? 1 : 0;
    assign g[3] = (state == D) ? 1 : 0;

endmodule
