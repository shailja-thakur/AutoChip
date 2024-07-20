module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [2:0] state, next_state;
  
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    always @(state or data) begin
        case (state)
            3'b000: begin
                if (data)
                    next_state = 3'b001;
                else
                    next_state = 3'b000;
            end
            3'b001: begin
                if (data)
                    next_state = 3'b011;
                else
                    next_state = 3'b000;
            end
            3'b011: begin
                if (data)
                    next_state = 3'b011;
                else
                    next_state = 3'b110;
            end
            3'b110: begin
                if (data)
                    next_state = 3'b111;
                else
                    next_state = 3'b000;
            end
            3'b111: next_state = 3'b111;
        endcase
    end

    assign start_shifting = (state == 3'b111);

endmodule
