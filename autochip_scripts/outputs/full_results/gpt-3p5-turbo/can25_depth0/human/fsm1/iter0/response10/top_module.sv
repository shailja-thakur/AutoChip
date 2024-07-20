module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    wire reset;

    // Assign reset signal based on areset input
    assign reset = areset;

    // Define state transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b1;   // State B
        end else begin
            case (state)
                2'b00: begin   // State A, input 0
                    if (in) begin
                        state <= 2'b00;  // Stay in State A
                    end else begin
                        state <= 2'b01;  // Go to State B
                    end
                end
                2'b01: begin   // State A, input 1
                    if (in) begin
                        state <= 2'b00;  // Go to State A
                    end else begin
                        state <= 2'b01;  // Stay in State A
                    end
                end
                2'b10: begin   // State B, input 0
                    if (in) begin
                        state <= 2'b10;  // Stay in State B
                    end else begin
                        state <= 2'b11;  // Go to State A
                    end
                end
                2'b11: begin   // State B, input 1
                    if (in) begin
                        state <= 2'b10;  // Go to State B
                    end else begin
                        state <= 2'b11;  // Stay in State B
                    end
                end
            endcase
        end
    end

    // Define output logic
    assign out = state[0];

endmodule
