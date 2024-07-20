module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// State definitions
parameter BYTE1 = 0;
parameter BYTE2 = 1;
parameter BYTE3 = 2;
parameter DONE = 3;

// Registers for state and next state
reg [1:0] state_reg;
reg [1:0] state_next;

// Done signal register
reg done_reg;

// Default values for registers
initial begin
    state_reg = BYTE1;
    done_reg = 0;
end

// State transition and output logic
always @(posedge clk) begin
    if (reset) begin
        state_reg <= BYTE1;
        done_reg <= 0;
    end else begin
        state_reg <= state_next;
        done_reg <= (state_reg == DONE);
    end
end

// Next state logic
always @(*) begin
    state_next = state_reg;
    
    case (state_reg)
        BYTE1: begin
            if (in[2] == 1) begin
                state_next = BYTE2;
            end
        end
        
        BYTE2: begin
            state_next = BYTE3;
        end
        
        BYTE3: begin
            state_next = DONE;
        end
        
        DONE: begin
            if (in[2] == 0) begin
                state_next = BYTE1;
            end else begin
                state_next = BYTE2;
            end
        end
    endcase
end

// Assign done output
assign done = done_reg;

endmodule
