module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

   // State definitions
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [2:0] x_history;
    reg [1:0] y_counter;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
	        x_history <= 3'b0;
	        y_counter <= 2'b0;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (state == STATE_B || state == STATE_C || state == STATE_D) begin
            x_history <= {x_history[1:0], x}; // Shift in new x value
        end
    end

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
        end else begin
            case (next_state)
                STATE_B:
                    f <= 1;
                default:
                    f <= 0;
            endcase 

	        if (state == STATE_E || state == STATE_F) begin
                if (y == 1) begin
                    g <= 1;
                end else if (y_counter == 2'b10) begin
                    g <= 0;
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (state == STATE_E || state == STATE_F) begin
            if (y == 1) begin
                y_counter <= 2'b00;
            end else begin
                y_counter <= y_counter + 1;
            end
        end
    end

    always_comb begin
        case (state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_history == 3'b011)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                next_state = STATE_E;
            end
            STATE_E: begin
                if (g == 1)
                    next_state = STATE_F;
                else if (y_counter == 2'b10)
                    next_state = STATE_F;
                else
                    next_state = STATE_E;
            end
            STATE_F: begin
                next_state = STATE_F;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
