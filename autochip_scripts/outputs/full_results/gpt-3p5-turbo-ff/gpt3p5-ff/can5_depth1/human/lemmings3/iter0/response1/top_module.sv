module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

// Define the states of the FSM
typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
} state_t;

// Define the outputs of the FSM
logic walk_left;
logic walk_right;
logic aaah;
logic digging;

// Define the state register
state_t current_state;

// Define the next state logic
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end else begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_right) begin
                    current_state <= WALK_RIGHT;
                end else if (!ground) begin
                    current_state <= FALL;
                end else if (dig) begin
                    current_state <= DIG;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    current_state <= WALK_LEFT;
                end else if (!ground) begin
                    current_state <= FALL;
                end else if (dig) begin
                    current_state <= DIG;
                end
            end
            FALL: begin
                if (ground) begin
                    current_state <= current_state;
                end else if (dig) begin
                    current_state <= DIG;
                end
            end
            DIG: begin
                if (!ground) begin
                    current_state <= FALL;
                end else begin
                    current_state <= current_state;
                end
            end
        endcase
    end
end

// Define the output logic
always_comb begin
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
        DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
    endcase
end

endmodule
