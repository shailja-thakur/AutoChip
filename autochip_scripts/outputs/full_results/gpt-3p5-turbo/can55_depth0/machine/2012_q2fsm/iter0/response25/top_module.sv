module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b0;
        else begin
            case (state)
                3'b000: begin // State A
                    if (w)  state <= 3'b001; // Transition to B
                    else    state <= 3'b000; // Continue in A
                end
                3'b001: begin // State B
                    if (w)  state <= 3'b010; // Transition to C
                    else    state <= 3'b100; // Transition to D
                end
                3'b010: begin // State C
                    if (w)  state <= 3'b101; // Transition to E
                    else    state <= 3'b100; // Transition to D
                end
                3'b011: begin // State D
                    if (w)  state <= 3'b111; // Transition to F
                    else    state <= 3'b000; // Transition to A
                end
                3'b101: begin // State E
                    if (w)  state <= 3'b101; // Continue in E
                    else    state <= 3'b100; // Transition to D
                end
                3'b111: begin // State F
                    if (w)  state <= 3'b110; // Transition to C
                    else    state <= 3'b100; // Transition to D
                end
                default: state <= 3'b0; // Default case for initial state
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3'b101 || state == 3'b111)
            z = 1;
        else
            z = 0;
    end
    
endmodule
