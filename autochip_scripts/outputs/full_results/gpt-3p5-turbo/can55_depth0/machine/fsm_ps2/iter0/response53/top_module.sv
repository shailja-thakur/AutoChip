module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State definition
    typedef enum logic [1:0] {
        BYTE1,
        BYTE2,
        BYTE3,
        DONE
    } state_t;
    
    // Registers
    reg state_t current_state;
    reg state_t next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always @* begin
        next_state = current_state;
        
        case (current_state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
                    next_state = BYTE2;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (in[2] == 1'b0) begin
                    next_state = BYTE1;
                end
                else begin
                    next_state = BYTE2;
                end
            end
        endcase
    end
    
    assign done = (current_state == DONE);
    
endmodule
