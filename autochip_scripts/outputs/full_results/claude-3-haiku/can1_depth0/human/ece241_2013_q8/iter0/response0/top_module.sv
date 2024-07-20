module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define the state variables
    reg [1:0] state, next_state;

    // Define the state encoding
    localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

    // Asynchronous reset
    always @(negedge aresetn) begin
        state <= S0;
        z <= 1'b0;
    end

    // State transition logic
    always @(posedge clk) begin
        state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b0;
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S2;
                    z = 1'b0;
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1;
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end
            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end

endmodule
