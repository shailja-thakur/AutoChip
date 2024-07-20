module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declaration using one-hot encoding
    reg [1:0] state;
    reg [1:0] next_state;

    localparam STATE_A = 2'b01;
    localparam STATE_B = 2'b10;

    // State transition on asynchronous reset or clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (x == 0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (x == 0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: next_state = STATE_A; // Default to initial state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (x == 0) begin
                    z = 0;
                end else begin
                    z = 1;
                end
            end
            STATE_B: begin
                if (x == 0) begin
                    z = 1;
                end else begin
                    z = 0;
                end
            end
            default: z = 0; // Default output
        endcase
    end

endmodule
