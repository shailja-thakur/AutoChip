module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] current_state, next_state;
    reg complement; // To store the complement bit
    
    // State encoding
    localparam State_IDLE = 2'd0;
    localparam State_ONE = 2'd1;
    localparam State_COMPLEMENT = 2'd2;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= State_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (current_state)
            State_IDLE: begin
                if (!areset) begin
                    next_state = State_ONE;
                    z = 1'b0;
                    complement = 1'b0;
                end else begin
                    next_state = State_IDLE;
                    z = 1'b0;
                end
            end
            State_ONE: begin
                next_state = State_COMPLEMENT;
                z = ~x;
                complement = ~x;
            end
            State_COMPLEMENT: begin
                next_state = State_COMPLEMENT;
                z = ~x ^ complement;
                complement = z;
            end
            default: begin
                next_state = State_IDLE;
                z = 1'b0;
            end
        endcase
    end

endmodule
