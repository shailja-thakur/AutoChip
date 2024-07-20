module top_module (
    input clk,
    input in,
    input reset,
    output done
);
    reg [2:0] state_reg, state_next;
    reg [7:0] data_reg;
    reg start_bit_detected;
    wire stop_bit_valid;
    
    assign done = state_reg[2];
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state_reg <= 3'b0;
        else
            state_reg <= state_next;
    end
    
    always @(state_reg or in) begin
        state_next = state_reg;
        
        case (state_reg)
            
            // Idle state, waiting for start bit
            3'b000: begin
                if (in == 1'b0)
                    state_next = 3'b001;
            end
            
            // Receiving data bits
            3'b001: begin
                start_bit_detected = 1;
                data_reg = 8'b0;
                state_next = 3'b010;
            end
            
            3'b010: begin
                data_reg = {data_reg[6:0], in};
                
                if (start_bit_detected && (data_reg == 8'b11111110))
                    state_next = 3'b011;
            end
            
            3'b011: begin
                state_next = 3'b100;
            end
            
            // Waiting for stop bit
            3'b100: begin
                if (in == 1'b1)
                    state_next = 3'b101;
            end
            
            3'b101: begin
                if (start_bit_detected && (data_reg[7:0] == 8'b11111110))
                    state_next = 3'b110;
                else
                    state_next = 3'b000;
            end
            
            3'b110: begin
                start_bit_detected = 0;
                state_next = 3'b000;
            end
            
        endcase
    end
endmodule
