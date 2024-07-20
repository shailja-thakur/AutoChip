module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output wire walk_left,
    output wire walk_right,
    output wire aaah,
    output wire digging
);

    reg [4:0] state; // current state
    reg [4:0] next_state; // next state

    reg [4:0] counter; // counts the number of clock cycles falling
    reg splatter; // indicates if the Lemming splatters

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00001; // initial state: walk left
            counter <= 5'b00000; // reset counter
            splatter <= 1'b0; // reset splatter
        end else begin
            state <= next_state; // update current state
            counter <= counter + 1; // increment counter every clock cycle

            // logic for determining next state
            case (state)
                5'b00001: // walking left
                    if (bump_right) begin
                        next_state = 5'b00010; // switch to walking right
                    end else if (counter >= 5'b10100 && ground) begin
                        next_state = 5'b00000; // splatter
                        splatter = 1'b1; // set splatter flag
                    end else if (dig && ground) begin
                        next_state = 5'b00100; // start digging
                    end else if (~ground) begin
                        next_state = 5'b01000; // fall
                        counter <= 5'b00000; // reset counter
                    end else begin
                        next_state = 5'b00001; // continue walking left
                    end
                5'b00010: // walking right
                    if (bump_left) begin
                        next_state = 5'b00001; // switch to walking left
                    end else if (counter >= 5'b10100 && ground) begin
                        next_state = 5'b00000; // splatter
                        splatter = 1'b1; // set splatter flag
                    end else if (dig && ground) begin
                        next_state = 5'b00100; // start digging
                    end else if (~ground) begin
                        next_state = 5'b01000; // fall
                        counter <= 5'b00000; // reset counter
                    end else begin
                        next_state = 5'b00010; // continue walking right
                    end
                5'b00100: // digging
                    if (~ground) begin
                        next_state = 5'b01000; // fall
                        counter <= 5'b00000; // reset counter
                    end else if (counter >= 5'b10100 && ground) begin
                        next_state = 5'b00000; // splatter
                        splatter = 1'b1; // set splatter flag
                    end else if (~dig) begin
                        next_state = 5'b00001; // stop digging and continue walking left
                    end else begin
                        next_state = 5'b00100; // continue digging
                    end
                5'b01000: // falling
                    if (ground) begin
                        next_state = 5'b00001; // continue walking left
                        counter <= 5'b00000; // reset counter
                    end else if (counter >= 5'b10100) begin
                        next_state = 5'b00000; // splatter
                        splatter = 1'b1; // set splatter flag
                    end else begin
                        next_state = 5'b01000; // continue falling
                    end
            endcase
        end
    end

    // output generation
    assign walk_left = (state == 5'b00001);
    assign walk_right = (state == 5'b00010);
    assign aaah = (state == 5'b00000 && splatter);
    assign digging = (state == 5'b00100);

endmodule
