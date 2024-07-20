module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State declarations
    typedef enum reg {
        STATE_NON_COMPL, // Reading input bits without complementing
        STATE_COMPL      // Complementing the bits
    } state_t;

    state_t state, next_state;
    reg carry; // Carry for adding 1 in 2's complement

    // State transition logic (Moore Machine)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_NON_COMPL;
            carry <= 1'b1; // Initialize carry to 1 for 2's complement operation
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_NON_COMPL: begin
                if (x == 1'b1) begin
                    next_state = STATE_COMPL;
                end else begin
                    next_state = STATE_NON_COMPL;
                end
            end

            STATE_COMPL: begin
                next_state = STATE_COMPL;
            end
            
            default: begin
                next_state = STATE_NON_COMPL;
            end
        endcase
    end

    // Output logic (Moore)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
        end else begin
            case (state)
                STATE_NON_COMPL: begin
                    // Direct pass without complement
                    z <= ~x;
                end 
                
                STATE_COMPL: begin
                    // Complement the bits and manage carry
                    z <= carry ^ x;
                    carry <= carry & x;
                end
            endcase
        end
    end
endmodule
