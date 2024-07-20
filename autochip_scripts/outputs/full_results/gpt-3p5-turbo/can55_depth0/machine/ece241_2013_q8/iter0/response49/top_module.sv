module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
	
    // Declare state register and next state wire
    reg [3:0] state;
    wire [3:0] state_next;
    
    // Initial state assignment. Assuming S = 000
    initial begin
        state = 4'b000;
    end
    
    // State transition and output logic
    always @(posedge clk) begin
        if (!aresetn) begin
            state <= 4'b000;
            z <= 1'b0;
        end
        else begin
            state <= state_next;
            case (state)
                4'b000: begin
                    if (x == 1'b0)
                        state_next = 4'b000;
                    else if (x == 1'b1)
                        state_next = 4'b001;
                end
                4'b001: begin
                    if (x == 1'b0)
                        state_next = 4'b100;
                    else if (x == 1'b1)
                        state_next = 4'b001;
                end
                4'b100: begin
                    if (x == 1'b0)
                        state_next = 4'b000;
                    else if (x == 1'b1)
                        state_next = 4'b001;
                end
            endcase
            case (state)
                4'b000: z = 1'b0;
                4'b001: z = 1'b0;
                4'b100: z = x;
            endcase
        end
    end
endmodule
