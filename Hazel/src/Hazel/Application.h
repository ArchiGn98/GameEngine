#pragma once
#include "Core.h"
#include "Hazel/Window.h"
#include "Events/ApplicationEvent.h"
#include "Hazel/Layers/LayerStack.h"

namespace Hazel
{
	class  HAZEL_API Application
	{
	public: 
		Application();
		virtual ~Application();

		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);
	private:
		bool OnWindowClosed(WindowCloseEvent& e);

		std::unique_ptr<Window> m_Window;
		bool m_Running = true;
		LayerStack m_LayerStack;
	};

	// To be defined in a client
	Application* CreateApplication();
}


