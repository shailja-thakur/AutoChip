module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [2:0] state; // FSM state register
    
    always @(posedge clk, negedge reset)
    begin
        if (reset)
            state <= 3'b000; // Reset state
        else
            case (state)
                3'b000: begin // Idle state
                    if (/* insert condition for detection of proper bit pattern */)
                        state <= 3'b001; // Enable shift_ena for 4 cycles
                    else
                        state <= 3'b000; // Stay in idle state
                end
                
                3'b001: begin // Shift_ena active state
                    if (/* insert condition for 4 clock cycles */)
                        state <= 3'b010; // Transition to next state
                    else
                        state <= 3'b001; // Stay in shift_ena active state
                end
                
                3'b010: begin // Shift_ena inactive state
                    state <= 3'b011; // Transition to next state
                end
                
                3'b011: begin // Transition state
                    state <= 3'b000; // Go back to idle state
                end
            endcase
    end
    
    assign shift_ena = (state == 3'b001); // Activate shift_ena only in state 3'b001
endmodule
