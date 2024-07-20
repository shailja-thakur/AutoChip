module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

// State encoding
localparam [1:0] STATE_A = 2'b00, 
                 STATE_B = 2'b01, 
                 STATE_C = 2'b10, 
                 STATE_D = 2'b11;

// State registers
reg [1:0] state, next_state;

// State transition logic (State table)
always @* begin
    case (state)
        STATE_A: begin
            if (r[1])
                next_state = STATE_B;
            else if (r[2])
                next_state = STATE_C;
            else
                next_state = (r[3]) ? STATE_D : STATE_A;
        end
        STATE_B: begin
            if (r[1])
                next_state = STATE_B;
            else 
                next_state = STATE_A;
        end
        STATE_C: begin
            if (r[2])
                next_state = STATE_C;
            else 
                next_state = STATE_A;
        end
        STATE_D: begin
            if (r[1])
                next_state = STATE_B;
            else if (r[2])
                next_state = STATE_C;
            else
                next_state = (r[3]) ? STATE_D : STATE_A;
        end
        default: 
            next_state = STATE_A;
    endcase
end

// State flip-flops (sequential logic)
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= STATE_A;
    else
        state <= next_state;
end

// Output logic
always @* begin
    g = 3'b000; // Default, no grants
    case (state)
        STATE_B: g[1] = 1'b1; // Grant to device 1
        STATE_C: g[2] = 1'b1; // Grant to device 2
        STATE_D: g[3] = 1'b1; // Grant to device 3
    endcase
end

endmodule
