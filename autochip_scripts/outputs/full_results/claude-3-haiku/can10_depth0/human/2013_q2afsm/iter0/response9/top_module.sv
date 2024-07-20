module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

// State definitions
localparam [1:0] 
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11;

// State registers
reg [1:0] state, next_state;

// State update logic
always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
        state <= STATE_A;
    end
    else begin
        state <= next_state;
    end
end

// State transition logic
always @(*) begin
    next_state = state;
    case(state)
        STATE_A: begin
            if(r[1]) begin
                next_state = STATE_B;
            end
            else if(r[2]) begin
                next_state = STATE_C;
            end
            else if(r[3]) begin
                next_state = STATE_D;
            end
        end
        STATE_B: begin
            if(r[1]) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        STATE_C: begin
            if(r[2]) begin
                next_state = STATE_C;
            end
            else begin
                next_state = STATE_A;
            end
        end
        STATE_D: begin
            next_state = STATE_A;
        end
    endcase
end

// Output logic
always @(*) begin
    g = 3'b000;
    case(state)
        STATE_B: begin
            g[1] = 1'b1;
        end
        STATE_C: begin
            g[2] = 1'b1;
        end
    endcase
end

endmodule
