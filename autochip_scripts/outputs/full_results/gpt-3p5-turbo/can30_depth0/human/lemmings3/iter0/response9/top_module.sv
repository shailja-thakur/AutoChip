module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

// Define the states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

// Define the state register
reg [1:0] state;

// Define internal signals
reg fall_start;
reg fall_end;
reg dig_start;
reg dig_end;

// Define the next state logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (dig && ground) begin
                    state <= DIG;
                end else if (ground == 0) begin
                    state <= FALL;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (dig && ground) begin
                    state <= DIG;
                end else if (ground == 0) begin
                    state <= FALL;
                end
            end
            FALL: begin
                if (ground) begin
                    state <= WALK_LEFT; // Resume walking in the same direction as before the fall
                end
            end
            DIG: begin
                if (dig_end) begin
                    state <= FALL;
                end
            end
        endcase
    end
end

// Define the output logic
always @* begin
    case (state)
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
            walk_left = 1;
            walk_right = 1;
            aaah = 0;
            digging = 1;
        end
    endcase
end

// Define the internal signals logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        fall_start <= 0;
        fall_end <= 0;
        dig_start <= 0;
        dig_end <= 0;
    end else begin
        fall_start <= ground == 0 && (bump_left || bump_right) && state != FALL; // Lemming starts falling
        fall_end <= ground == 1 && state == FALL; // Lemming hits ground after falling
        dig_start <= dig && ground == 1 && (state == WALK_LEFT || state == WALK_RIGHT); // Lemming starts digging
        dig_end <= ground == 0 && state == DIG; // Lemming hits no ground after digging
    end
end

endmodule
