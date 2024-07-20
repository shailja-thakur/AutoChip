module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [1:0] count; // To count up to 2 cycles for y check

    always @(posedge clk or negedge resetn) begin
        if (!resetn) 
            state <= STATE_A;
        else 
            state <= next_state;
    end 

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            count <= 0;
        end 
        else begin
            case (state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                    if (!resetn) state <= STATE_A; 
                    else state <= STATE_B;
                end
                STATE_B: begin
                    f <= 1;
                    g <= 0;
                    state <= STATE_C;
                end
                STATE_C: begin
                    f <= 0;
                    if (x == 1) state <= STATE_D;
                    else state <= STATE_C;
                end
                STATE_D: begin
                    if (x == 0) state <= STATE_E;
                    else state <= STATE_D;
                end
                STATE_E: begin
                    if (x == 1) begin
                        g <= 1;
                        state <= STATE_F;
                        count <= 0;
                    end
                    else state <= STATE_E;
                end
                STATE_F: begin
                    if (g && y == 1) begin
                        g <= 1;
                        count <= 0;  // Reset count
                    end 
                    else if (g && y == 0 && count < 2) begin
                        g <= 1;
                        count <= count + 1;
                    end 
                    else if (g && y == 0 && count == 2) begin
                        g <= 0;
                    end
                end
            endcase
        end
    end 

endmodule
