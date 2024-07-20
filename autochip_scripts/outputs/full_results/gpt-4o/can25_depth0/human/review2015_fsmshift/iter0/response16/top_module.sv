module top_module (
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state;
    reg [2:0] next_state;
    reg [1:0] shift_counter;

    // State encoding
    localparam S_IDLE = 3'b000;
    localparam S_SHIFT = 3'b001;
    localparam S_DONE = 3'b010;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S_IDLE: begin
                if (reset) begin
                    next_state = S_SHIFT;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_SHIFT: begin
                if (shift_counter == 2'd3) begin
                    next_state = S_DONE;
                end else begin
                    next_state = S_SHIFT;
                end
            end
            S_DONE: begin
                next_state = S_DONE;
            end
            default: next_state = S_IDLE;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Output and counter logic
    always @(posedge clk) begin
        if (reset) begin
            shift_counter <= 2'd0;
            shift_ena <= 1'b0;
        end else if (state == S_SHIFT) begin
            shift_ena <= 1'b1;
            shift_counter <= shift_counter + 1;
        end else begin
            shift_ena <= 1'b0;
        end
    end

endmodule
