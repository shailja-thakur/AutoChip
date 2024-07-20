module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states of the Moore state machine
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Internal state register
    reg state;

    // Asynchronous reset
    always @(posedge areset) begin
        state <= B;
    end

    // State transition and output logic
    always @(posedge clk) begin
        case (state)
            A: begin
                out <= 0;
                if (in == 0)
                    state <= B;
                else
                    state <= A;
            end
            B: begin
                out <= 1;
                if (in == 0)
                    state <= B;
                else
                    state <= A;
            end
        endcase
    end

endmodule
