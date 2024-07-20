module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;
    reg [2:0] count, next_count;
    
    // State encoding
    localparam IDLE = 3'd0;
    localparam SHIFT = 3'd1;

    // State transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 3'b000;
        end else begin
            state <= next_state;
            count <= next_count;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        next_count = count;
        case (state)
            IDLE: begin
                shift_ena = 0;
                if (reset) begin
                    next_state = SHIFT;
                    next_count = 3'd4;
                end
            end
            SHIFT: begin
                shift_ena = 1;
                if (count > 3'b001) begin
                    next_count = count - 1;
                end else begin
                    next_state = IDLE;
                    next_count = 3'b000;
                end
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b0;
        end else if (next_state == SHIFT && next_count != 3'b000) begin
            shift_ena <= 1'b1;
        end else begin
            shift_ena <= 1'b0;
        end
    end

endmodule
