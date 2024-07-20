module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

// Define the states
localparam [2:0] SEARCH = 3'b000, 
                 SHIFTING = 3'b001,
                 COUNTING = 3'b010,
                 NOTIFY = 3'b011;

reg [2:0] state, next_state;
reg [3:0] shift_count;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= SEARCH;
        shift_count <= 0;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        SEARCH: begin
            if (data == 1'b1) begin
                if ({data, shift_count[3:1]} == 4'b1101) begin
                    next_state = SHIFTING;
                    shift_count = 0;
                end
                else begin
                    shift_count = {data, shift_count[3:1]};
                end
            end
        end
        SHIFTING: begin
            if (shift_count == 4'b1111) begin
                next_state = COUNTING;
            end
            else begin
                shift_count = shift_count + 1;
            end
        end
        COUNTING: begin
            if (done_counting) begin
                next_state = NOTIFY;
            end
        end
        NOTIFY: begin
            if (ack) begin
                next_state = SEARCH;
            end
        end
        default: next_state = SEARCH;
    endcase
end

// Output logic
always @(*) begin
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (state)
        SHIFTING: shift_ena = 1;
        COUNTING: counting = 1;
        NOTIFY: done = 1;
    endcase
end

endmodule
