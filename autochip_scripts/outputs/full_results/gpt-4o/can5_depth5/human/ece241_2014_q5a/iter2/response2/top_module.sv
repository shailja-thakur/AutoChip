module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum logic [1:0] {
        INIT     = 2'b00,
        FLIP     = 2'b01,
        ADD_ONE  = 2'b10
    } state_t;

    // State variable
    state_t state, next_state;

    // Flip-flop to track if the flip stage is done
    reg flip_done;
    
    // Reg to hold the flip + add 1 result
    reg flip_add_result;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= INIT;
            flip_done <= 1'b0;
            z <= 1'b0;
        end 
        else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            INIT: begin
                next_state = FLIP;
            end
            FLIP: begin
                next_state = ADD_ONE;
            end
            ADD_ONE: begin
                next_state = FLIP;
            end
            default: begin
                next_state = INIT;
            end
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            flip_done <= 1'b0;
            flip_add_result <= 1'b0;
        end 
        else begin
            case (state)
                INIT: begin
                    flip_add_result <= 1'b0;
                end
                FLIP: begin
                    flip_add_result <= ~x; // Flip bits
                    flip_done <= 1'b1;
                end
                ADD_ONE: begin
                    if (flip_done) begin
                        z <= flip_add_result + 1'b1; // Add 1 to flipped bits
                        flip_done <= 1'b0;
                    end else begin
                        z <= flip_add_result;
                    end
                end
            endcase
        end
    end

endmodule
