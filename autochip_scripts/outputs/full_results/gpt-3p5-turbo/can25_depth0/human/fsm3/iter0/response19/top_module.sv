module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // Define the states
    reg [1:0] state;
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // Define the outputs
    reg output;

    // Sequential logic process
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            state <= A;
        end else begin
            // State transition logic
            case (state)
                A: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                    output <= 0;
                end
                B: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= C;
                    end
                    output <= 0;
                end
                C: begin
                    if (in) begin
                        state <= D;
                    end else begin
                        state <= A;
                    end
                    output <= 0;
                end
                D: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= C;
                    end
                    output <= 1;
                end
            endcase
        end
    end

    // Assign the output
    assign out = output;

endmodule
