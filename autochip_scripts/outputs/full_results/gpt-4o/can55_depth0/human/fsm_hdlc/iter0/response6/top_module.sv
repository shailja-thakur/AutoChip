module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum reg [3:0] {
        IDLE    = 4'd0,
        S0      = 4'd1,
        S01     = 4'd2,
        S011    = 4'd3,
        S0111   = 4'd4,
        S01111  = 4'd5,
        S011111 = 4'd6,
        S0111110 = 4'd7,
        ERROR   = 4'd8
    } state_t;
    
    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic based on current state and input 'in'
    always @(*) begin
        next_state = current_state;
        disc = 0;
        flag = 0;
        err = 0;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) 
                    next_state = S0;
            end
            
            S0: begin
                if (in == 1'b1)
                    next_state = S01;
                else
                    next_state = IDLE;
            end
            
            S01: begin
                if (in == 1'b1)
                    next_state = S011;
                else
                    next_state = IDLE;
            end
            
            S011: begin
                if (in == 1'b1)
                    next_state = S0111;
                else
                    next_state = IDLE;
            end
            
            S0111: begin
                if (in == 1'b1)
                    next_state = S01111;
                else
                    next_state = IDLE;
            end
            
            S01111: begin
                if (in == 1'b1)
                    next_state = S011111;
                else
                    next_state = IDLE;
            end
            
            S011111: begin
                if (in == 1'b0)
                    next_state = S0111110;
                else 
                    next_state = ERROR;
            end
            
            S0111110: begin
                if (in == 1'b1) begin
                    next_state = S0;
                    flag = 1;
                end else begin
                    next_state = S011;
                    disc = 1;
                end
            end
            
            ERROR: begin
                err = 1;
                if (in == 1'b0)
                    next_state = S0;
            end
            
        endcase
    end
    
endmodule
