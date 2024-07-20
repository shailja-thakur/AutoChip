module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @* begin
    case(state)
        2'b00: begin //State A
            if(in == 1'b0) begin
                next_state = 2'b00; //Stays in State A
            end
            else begin
                next_state = 2'b01; //Goes to State B
            end
            out = 1'b0;
        end
        
        2'b01: begin //State B
            if(in == 1'b0) begin
                next_state = 2'b10; //Goes to State C
            end
            else begin
                next_state = 2'b01; //Stays in State B
            end
            out = 1'b0;
        end
        
        2'b10: begin //State C
            if(in == 1'b0) begin
                next_state = 2'b00; //Goes to State A
            end
            else begin
                next_state = 2'b11; //Goes to State D
            end
            out = 1'b0;
        end
        
        2'b11: begin //State D
            if(in == 1'b0) begin
                next_state = 2'b10; //Goes to State C
            end
            else begin
                next_state = 2'b01; //Goes to State B
            end
            out = 1'b1;
        end
        
        default: begin
            next_state = 2'b00; //Default next state
            out = 1'b0; //Default output
        end
    endcase
end

endmodule
