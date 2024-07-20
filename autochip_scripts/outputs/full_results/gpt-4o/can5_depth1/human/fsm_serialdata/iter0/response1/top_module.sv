module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] shift_reg;

    // State encoding
    localparam IDLE     = 4'd0;
    localparam START    = 4'd1;
    localparam DATA     = 4'd2;
    localparam STOP     = 4'd3;
    localparam ERROR    = 4'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            shift_reg <= 8'd0;
            done <= 1'b0;
            out_byte <= 8'd0;
        end else begin
            state <= next_state;
            if (state == START) begin
                bit_counter <= 3'd0;
                shift_reg <= 8'd0;
            end else if (state == DATA) begin
                shift_reg <= {in, shift_reg[7:1]}; // Shift data bits into shift_reg
                bit_counter <= bit_counter + 3'd1;
            end else if (state == STOP && in == 1'b1) begin
                out_byte <= shift_reg;
                done <= 1'b1;
            end else if (state == IDLE || state == ERROR) begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = state; // Default to stay in the current state
        case(state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START; // Detected start bit
                end
            end
            START: begin
                next_state = DATA; // Move to data state
            end
            DATA: begin
                if (bit_counter == 3'd7) begin
                    next_state = STOP; // All data bits received, move to stop state
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE; // Correct stop bit, move to idle
                end else begin
                    next_state = ERROR; // Incorrect stop bit, move to error state
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE; // Wait until line returns to idle
                end
            end
        endcase
    end
endmodule
