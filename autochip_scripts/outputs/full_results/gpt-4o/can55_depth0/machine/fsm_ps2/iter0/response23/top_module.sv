module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    reg [1:0] state, next_state;
    reg done_reg;
    
    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE  = 2'b11;
    
    assign done = (state == DONE);
    
    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            BYTE1: begin
                if (in[2])
                    next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (~in[2])
                    next_state = BYTE1;
                else
                    next_state = BYTE2;
            end
            default: next_state = BYTE1;
        endcase
    end
    
    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done_reg <= 0;
        end
        else if (state == DONE) begin
            done_reg <= 1;
        end
        else begin
            done_reg <= 0;
        end
    end
    
endmodule
