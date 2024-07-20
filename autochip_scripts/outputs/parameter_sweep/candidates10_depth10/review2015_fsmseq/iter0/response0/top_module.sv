module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
);

    reg [3:0] state;                 // 4-bit state variable
    reg start_shifting_reg;          // register to hold the start_shifting value

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;        // reset to initial state
            start_shifting_reg <= 1'b0;  // reset start_shifting register
        end else begin
            case(state)
                4'b0000: begin
                    if (data) state <= 4'b0001;   // transition to state 1 if input data is high
                end
                4'b0001: begin
                    if (data) state <= 4'b0011;   // transition to state 3 if input data is high
                    else state <= 4'b0000;       // transition back to state 0 if input data is low
                end
                4'b0011: begin
                    if (data) state <= 4'b0111;   // transition to state 7 if input data is high
                    else state <= 4'b0000;       // transition back to state 0 if input data is low
                end
                4'b0111: begin
                    if (data) state <= 4'b0110;   // transition to state 6 if input data is high
                    else state <= 4'b0000;       // transition back to state 0 if input data is low
                end
                4'b0110: begin
                    if (data) state <= 4'b0001;   // transition to state 1 if input data is high
                    else state <= 4'b0000;       // transition back to state 0 if input data is low
                end
                default: state <= 4'b0000;        // default transition to state 0
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            start_shifting_reg <= 1'b0;   // reset start_shifting register
        end else begin
            if (state == 4'b0110) begin
                start_shifting_reg <= 1'b1;   // set start_shifting to 1 when the sequence is found
            end
        end
    end

    assign start_shifting = start_shifting_reg;   // assign start_shifting register to output

endmodule
