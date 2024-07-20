module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S2   = 3'b010,
        S3   = 3'b011,
        FOUND= 3'b100
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = S1;
                end else begin
                    next_state = IDLE;
                end
                start_shifting = 1'b0;
            end
            
            S1: begin
                if (data == 1'b1) begin
                    next_state = S2;
                end else begin
                    next_state = IDLE;
                end
                start_shifting = 1'b0;
            end
            
            S2: begin
                if (data == 1'b0) begin
                    next_state = S3;
                end else begin
                    next_state = S1;
                end
                start_shifting = 1'b0;
            end
            
            S3: begin
                if (data == 1'b1) begin
                    next_state = FOUND;
                end else begin
                    next_state = IDLE;
                end
                start_shifting = 1'b0;
            end
            
            FOUND: begin
                next_state = FOUND;
                start_shifting = 1'b1;
            end
            
            default: begin
                next_state = IDLE;
                start_shifting = 1'b0;
            end
        endcase
    end
endmodule
