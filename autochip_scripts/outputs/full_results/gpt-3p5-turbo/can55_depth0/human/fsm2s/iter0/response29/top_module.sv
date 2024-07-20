module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) // Synchronous Reset
            state <= 2'b0;
        else begin
            case (state)
                2'b00: if (j) state <= 2'b01; else state <= 2'b00; // OFF -> OFF / OFF -> ON
                2'b01: if (k) state <= 2'b00; else state <= 2'b01; // ON -> OFF / ON -> ON
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: out = 1'b0; // OFF state
            2'b01: out = 1'b1; // ON state
        endcase
    end
endmodule
