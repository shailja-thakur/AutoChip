module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the state variables
    reg [1:0] state;
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            case (state)
                A: begin
                    if (in == 0) begin
                        state <= A;
                    end
                    else begin
                        state <= B;
                    end
                end
                B: begin
                    if (in == 0) begin
                        state <= C;
                    end
                    else begin
                        state <= B;
                    end
                end
                C: begin
                    if (in == 0) begin
                        state <= A;
                    end
                    else begin
                        state <= D;
                    end
                end
                D: begin
                    if (in == 0) begin
                        state <= C;
                    end
                    else begin
                        state <= B;
                    end
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            A, B, C: out = 0;
            D: out = 1;
        endcase
    end

endmodule
