module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define states
    reg [2:0] state;
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (w) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    if (w) begin
                        state <= C;
                    end else begin
                        state <= D;
                    end
                end
                C: begin
                    if (w) begin
                        state <= E;
                    end else begin
                        state <= D;
                    end
                end
                D: begin
                    if (w) begin
                        state <= F;
                    end else begin
                        state <= A;
                    end
                end
                E: begin
                    if (w) begin
                        state <= E;
                    end else begin
                        state <= D;
                    end
                end
                F: begin
                    if (w) begin
                        state <= C;
                    end else begin
                        state <= D;
                    end
                end
            endcase
        end
    end

    // Output z
    always @* begin
        if (state == E || state == F) begin
            z = 1;
        end else begin
            z = 0;
        end
    end
    
endmodule
