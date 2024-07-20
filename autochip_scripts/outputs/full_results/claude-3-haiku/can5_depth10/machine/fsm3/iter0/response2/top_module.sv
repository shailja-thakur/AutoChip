module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the state register
    reg [1:0] state;

    // Define the states
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            case (state)
                A: begin
                    if (in) begin
                        state <= B;
                    end
                    else begin
                        state <= A;
                    end
                end
                B: begin
                    if (in) begin
                        state <= B;
                    end
                    else begin
                        state <= C;
                    end
                end
                C: begin
                    if (in) begin
                        state <= D;
                    end
                    else begin
                        state <= A;
                    end
                end
                D: begin
                    if (in) begin
                        state <= B;
                    end
                    else begin
                        state <= C;
                    end
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        out = (state == D);
    end

endmodule
