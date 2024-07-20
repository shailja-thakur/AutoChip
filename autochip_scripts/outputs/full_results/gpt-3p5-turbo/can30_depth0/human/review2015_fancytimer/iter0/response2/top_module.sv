module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

// Declare signals
reg [3:0] delay;
reg [3:0] count_r;

reg [3:0] shift_reg;
reg [3:0] next_shift_reg;
reg [3:0] count_reg;
reg [3:0] next_count_reg;

reg [3:0] state;
reg [3:0] next_state;

// Define state values
parameter IDLE = 4'b0000;
parameter SEARCH = 4'b0001;
parameter SHIFT = 4'b0010;
parameter COUNT = 4'b0011;
parameter NOTIFY = 4'b0100;
parameter WAIT_ACK = 4'b0101;

// Sequential logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        counting <= 0;
        done <= 0;
        state <= IDLE;
        delay <= 0;
        count_r <= 0;
        shift_reg <= 0;
        count_reg <= 0;
    end else begin
        counting <= (state == COUNT);
        done <= (state == NOTIFY);
        state <= next_state;
        delay <= data;
        count_r <= count_reg;
        shift_reg <= next_shift_reg;
        count_reg <= next_count_reg;
    end
end

// Combinational logic
always @* begin
    case(state)
        IDLE: begin
            next_shift_reg = shift_reg;
            next_count_reg = count_reg;
            if (data == 4'b1101) begin
                next_state = SHIFT;
            end else begin
                next_state = IDLE;
            end
        end
        
        SEARCH: begin
            next_shift_reg = shift_reg;
            next_count_reg = count_reg;
            if (data == 4'b1101) begin
                next_state = SHIFT;
            end else begin
                next_state = SEARCH;
            end
        end
        
        SHIFT: begin
            next_shift_reg = {shift_reg[2:0], data[0]};
            next_count_reg = count_reg;
            next_state = COUNT;
        end
        
        COUNT: begin
            next_shift_reg = shift_reg;
            if (count_reg == delay) begin
                next_count_reg = count_reg + 1;
                next_state = NOTIFY;
            end else begin
                next_count_reg = count_reg + 1;
                next_state = COUNT;
            end
        end
        
        NOTIFY: begin
            next_shift_reg = shift_reg;
            next_count_reg = count_reg;
            if (ack) begin
                next_state = WAIT_ACK;
            end else begin
                next_state = NOTIFY;
            end
        end
        
        WAIT_ACK: begin
            next_shift_reg = shift_reg;
            next_count_reg = count_reg;
            if (!ack) begin
                next_state = IDLE;
            end else begin
                next_state = WAIT_ACK;
            end
        end
    endcase
end

// Output assignments
assign count = count_r;

endmodule
