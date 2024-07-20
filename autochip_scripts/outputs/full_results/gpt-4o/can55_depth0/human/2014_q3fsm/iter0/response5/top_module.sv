module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        COUNT1 = 2'b10,
        COUNT2 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;  // to count the number of '1's in three cycles of w
    reg [1:0] cycle_count;  // to count the three cycles

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == B || state == COUNT1 || state == COUNT2) begin
                if (cycle_count < 2) begin
                    cycle_count <= cycle_count + 1;
                end else begin
                    cycle_count <= 0;
                end

                if (cycle_count < 2) begin
                    if (w) w_count <= w_count + 1;
                end else if (cycle_count == 2) begin
                    if (w) w_count <= w_count + 1;
                    if (w_count == 2) z <= 1;
                    else z <= 0;
                end
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                next_state = COUNT1;
            end
            COUNT1: begin
                if (cycle_count == 2) next_state = (w_count == 2) ? B : COUNT2;
                else next_state = COUNT1;
            end
            COUNT2: begin
                if (cycle_count == 2) next_state = (w_count == 2) ? B : A;
                else next_state = COUNT2;
            end
            default: next_state = A;
        endcase
    end
endmodule
